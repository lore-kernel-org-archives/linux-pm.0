From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] PM core: rename suspend and resume functions
Date: Thu, 21 May 2009 16:54:43 +0900
Message-ID: <aec7e5c30905210054q24c121dfj555e9029beb39686@mail.gmail.com>
References: <Pine.LNX.4.44L0.0905191051240.2646-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0905191051240.2646-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, May 19, 2009 at 11:53 PM, Alan Stern <stern@rowland.harvard.edu> wr=
ote:
> This patch (as1241) renames a bunch of functions in the PM core.
> Rather than go through a boring list of name changes, suffice it to
> say that in the end we have a bunch of pairs of functions:
>
> =A0 =A0 =A0 =A0device_resume_noirq =A0 =A0 dpm_resume_noirq
> =A0 =A0 =A0 =A0device_resume =A0 =A0 =A0 =A0 =A0 dpm_resume
> =A0 =A0 =A0 =A0device_complete =A0 =A0 =A0 =A0 dpm_complete
> =A0 =A0 =A0 =A0device_suspend_noirq =A0 =A0dpm_suspend_noirq
> =A0 =A0 =A0 =A0device_suspend =A0 =A0 =A0 =A0 =A0dpm_suspend
> =A0 =A0 =A0 =A0device_prepare =A0 =A0 =A0 =A0 =A0dpm_prepare
>
> in which device_X does the X operation on a single device and dpm_X
> invokes device_X for all devices in the dpm_list.
>
> In addition, the old dpm_power_up and device_resume_noirq have been
> combined into a single function (dpm_resume_noirq).
>
> Lastly, dpm_suspend_start and dpm_resume_end are the renamed versions
> of the former top-level device_suspend and device_resume routines.
>
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Looks like a bigger step in the right direction. =3D)
Applied on top of next-20090520, compiles fine on SuperH with
sh7724_generic_defconfig.

Acked-by: Magnus Damm <damm@igel.co.jp>
