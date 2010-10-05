From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Question about hibernation
Date: Wed, 6 Oct 2010 00:43:30 +0200
Message-ID: <201010060043.30489.rjw@sisk.pl>
References: <BLU102-W1030ED196ED7B94722F2A7EB830@phx.gbl>
	<BLU102-W16DEFB6CCB93D518FD5745EB7C0@phx.gbl>
	<BLU102-W27AEE84EC4B31E9F85FF13EB6D0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BLU102-W27AEE84EC4B31E9F85FF13EB6D0@phx.gbl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, October 05, 2010, Raj Kumar wrote:
> 
> Hi Alan,
>  
> I have question regarding the hibernation mode in linux. 
>  
> 1) In normal suspend to ram, is freezing of tasks necessary while suspend to ram in current linux power management core?

Yes, it is.

> 2) In hibernation mode, is freezing of tasks done before normal suspend/resumes in order to that hibernation image is in sync?

That depends on what you mean by normal "suspend/resumes".  Generally speaking,
the hibernate code freezes tasks before preallocating image memory.

> My issue is because it might be possible that there is some part of device driver which is user space and another part is kernel space
> then in suspend to ram and hibernation mode is freezing of all user space part is done before kernel side or it differs while
> suspend to ram and hibernation mode?

User space is always frozen before suspend and hibernation.

Thanks,
Rafael
