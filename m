From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bug 14730] sky2 won't work after suspend/resume
	cycle
Date: Fri, 11 Dec 2009 22:00:53 +0100
Message-ID: <200912112200.53314.rjw@sisk.pl>
References: <bug-14730-10028@http.bugzilla.kernel.org/>
	<200912110834.nBB8YgJr022469@demeter.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912110834.nBB8YgJr022469@demeter.kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: bugzilla-daemon@bugzilla.kernel.org
Cc: pm list <linux-pm@lists.linux-foundation.org>, vyacheslavovich@gmail.com
List-Id: linux-pm@vger.kernel.org

On Friday 11 December 2009, bugzilla-daemon@bugzilla.kernel.org wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=14730
> 
> --- Comment #23 from Ilya Hegai <vyacheslavovich@gmail.com>  2009-12-11 08:34:41 ---
> Me too) because I'm still experiencing that problem, yesterday several
> hibernate/resume cycles went smoothly, but today I've got that error again, so
> it's not reproducible always which makes "patch hunting" work harder

So the commit we have discussed doesn't help to fix resume on your box after
all?

> And unfortunately I can play with 2.6.31.X only, because resume in 2.6.32 is
> completely broken for my laptop

I think you should file a separate bug report about that.

Is there any kernel where suspend/resume works reliably on your box?
