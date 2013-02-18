From: Alex Courbot <acourbot@nvidia.com>
Subject: Re: usb_wwan_write() called while device still being resumed
Date: Mon, 18 Feb 2013 12:20:26 +0900
Message-ID: <51219DFA.6070902@nvidia.com>
References: <511CBCE8.9070204@nvidia.com> <87ehgivlmg.fsf@nemi.mork.no> <511DF09F.3070401@nvidia.com> <87r4khu9az.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87r4khu9az.fsf@nemi.mork.no>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?QmrDuHJuIE1vcms=?= <bjorn@mork.no>
Cc: USB list <linux-usb@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 02/15/2013 08:05 PM, Bj=C3=B8rn Mork wrote:
> Maybe something like the completely untested:
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtim=
e.c
> index 3148b10..38e19ba 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -512,6 +512,9 @@ static int rpm_resume(struct device *dev, int rpm=
flags)
>   	else if (dev->power.disable_depth =3D=3D 1 && dev->power.is_suspen=
ded
>   	    && dev->power.runtime_status =3D=3D RPM_ACTIVE)
>   		retval =3D 1;
> +	else if (rpmflags & RPM_ASYNC && dev->power.request_pending &&
> +		 dev->power.request =3D=3D RPM_REQ_RESUME)
> +		retval =3D -EINPROGRESS;
>   	else if (dev->power.disable_depth > 0)
>   		retval =3D -EACCES;
>   	if (retval)

Second thought: not sure this will work since power.request_pending and=
=20
power.request are set to these values later in the same rpm_resume()=20
function. However, the three lines before yours caught my attention.=20
They are not in my 3.1 source tree and the conditions are very close=20
from the ones I am seeing when the issue happens: disable_depth =3D=3D =
1,=20
is_suspended =3D=3D 1. Only runtime_status is not equal to RPM_ACTIVE.

Nonetheless, I have looked at the patch that introduced these=20
(http://pastebin.com/PmHUjiAE ) and it details a problem that is very=20
similar to mine. It also mentions a workaround to be implemented in the=
=20
driver by saving the suspend status into a variable that is checked whe=
n=20
pm_runtime_get() return -EACCES. This variable already exists in=20
usb_wwan, actually it is the very variable that is checked a bit later=20
in that other chunk of code you mentioned:

spin_lock_irqsave(&intfdata->susp_lock, flags);
if (intfdata->suspended) {
	usb_anchor_urb(this_urb, &portdata->delayed);
	spin_unlock_irqrestore(&intfdata->susp_lock, flags);
} else {

So it looks like this code is here for exactly that purpose. However in=
=20
my current condition I do not see how this block could be run since=20
runtime PM is disabled when intfdata->suspended is set to true.

I will try implementing the workaround suggested (checking if=20
intfdata->suspended is set when -EACCES is returned and go on if it is=20
the case) and see if it works (and I bet it will). In the upstream=20
kernel the issue seems to have been addressed already, so this might=20
just be a source-out-of-date issue.

Thanks,
Alex.
