From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: [RFC,
	PATCHv3 3/3] mmc: sdhci: handle wake-up from runtime_pm
Date: Tue, 1 Mar 2011 21:01:50 +0100
Message-ID: <AANLkTikt1r3j99_ub0ce3_3snjoDXvR2+x6RxcjGfMK8__40446.6512649835$1299010083$gmane$org@mail.gmail.com>
References: <b01ca43311e25bf24c6e60e9f6d6d7b91ae3a130.1298820826.git.tardyp@gmail.com>
	<Pine.LNX.4.44L0.1103011448430.2034-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1103011448430.2034-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

>> + =A0 =A0 if (pm_runtime_suspended()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->waking_up =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Note that we disable temporarly the interru=
pt until we do the
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* resume. If we don't then we'll get consta=
ntly interrupted
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* until we actually resume.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* as the irq is shared, this might not be v=
ery friendly to our
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* irq sharers but the pm_runtime workqueue =
should really be
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* called soon.
>
> Instead of disabling the IRQ, would it be possible to tell the device
> to stop generating an interrupt request?

Well, the device is power gated, so any access to it will cause a bus
timeout (depending of the platform)

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 disable_irq_nosync(irq);
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get(host->mmc->parent);
>
> Does this pm_runtime_get() have a corresponding pm_runtime_put()? =A0I
> didn't notice one anywhere.
oups, forgot to add the corresponding snippet in sdhci_runtime_resume:
if (host->waking_up) {
    pm_runtime_put();
    host->waking_up =3D 0;
}

>>
>
> Surely this doesn't belong in the patch.
yep sorry, I should stop doing git commit -a...

Pierre
