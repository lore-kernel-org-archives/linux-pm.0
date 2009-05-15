From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] pm: rename device_power_down/up()
Date: Fri, 15 May 2009 12:04:17 +0900
Message-ID: <aec7e5c30905142004v5f5277e2h470ed0af9d4580db@mail.gmail.com>
References: <200905141943.53151.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0905141421130.4344-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0905141421130.4344-100000@iolanthe.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org, Greg KH <gregkh@suse.de>, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, May 15, 2009 at 3:39 AM, Alan Stern <stern@rowland.harvard.edu> wro=
te:
> So I suggest even more renaming on top of these changes:
>
> =A0 =A0 =A0 =A0resume_device -> device_resume
> =A0 =A0 =A0 =A0complete_device -> device_complete
> =A0 =A0 =A0 =A0device_resume - > dpm_resume_all
>
> =A0 =A0 =A0 =A0suspend_device -> device_suspend
> =A0 =A0 =A0 =A0prepare_device -> device_prepare
> =A0 =A0 =A0 =A0device_suspend -> dpm_suspend_all
>
> How does that sound?

Renaming more sounds good!

I did however name the _noirq functions to follow device_suspend() and
device_resume(). So feel free to rename the _norirq functions again if
you rename device_suspend() and device_resume() according to the list
above.

Thanks!

/ magnus
