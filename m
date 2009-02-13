From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Thu, 12 Feb 2009 18:21:20 -0800
Message-ID: <d6200be20902121821o6d60140bu28bc6e60b83d6ec7@mail.gmail.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200902112323.53421.rjw@sisk.pl>
	<d6200be20902111542r3592f64dt41a282221aed1268@mail.gmail.com>
	<200902122322.30864.rjw@sisk.pl>
	<13B9B4C6EF24D648824FF11BE89671620377169672@dlee02.ent.ti.com>
	<20090213011035.GA8664@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090213011035.GA8664@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "ncunningham@crca.org.au" <ncunningham@crca.org.au>, "swetland@google.com" <swetland@google.com>, "u.luckas@road.de" <u.luckas@road.de>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 12, 2009 at 5:10 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrot=
e:
> I dislike the kernel-side use of wakelocks. They're basically equivalent
> to a device returning -EBUSY during the suspend phase, which is
> something that can be done without any kernel modifications.

I don't get why people object to wakelocks supporting timeouts, but
think drivers returning -EBUSY to abort suspend is ok. If suspend
fails, the higher level code has to periodically retry until it can
succeed. This means that the device is awake for longer than it need
to, and you are repeatedly wasting time freezing all tasks and
suspending a set of drivers before you get to the driver that is
preventing suspend.

-- =

Arve Hj=F8nnev=E5g
