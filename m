From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [REGRESSION]: hibernate/sleep regression w/ bisection
Date: Tue, 1 Nov 2011 22:46:58 -0700
Message-ID: <20111102054658.GA29035@core.coreip.homeip.net>
References: <20111101124759.GA1326@zeus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20111101124759.GA1326@zeus>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Watts <akwatts@ymail.com>
Cc: tj@kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Andrew,

On Tue, Nov 01, 2011 at 07:48:19AM -0500, Andrew Watts wrote:
> Hi.
> 
> Hibernate/sleep (echo disk/mem > /sys/power/state) has presented problems
> for me starting with 2.6.39. Kernel 2.6.37.6 was the last completely bug-free
> version I used (I skipped the 2.6.38 branch entirely).
> 
> The symptoms are that upon resume (from sleep/hibernate) there is no video
> nor any keyboard input with the exception of sysrq.

If SysRq is working that means that i8042, atkbd and input core are
working properly.

> 
> It has been a frustrating bug to hunt down because it is not easily
> reproduced; sometimes the bug doesn't pop up until after a long sequence of
> hibernate/sleep cycles.
> 
> I successfully bisected the problem to: 8ee294cd9def000.
> 
> =======
> Commit: 8ee294cd9def0004887da7f44b80563493b0a097
> Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Date:   Mon Nov 15 01:39:57 2010 -0800
> Input: serio - convert to common workqueue instead of a thread
> =======
> 
> Backing out 8ee294cd9def000 (which requires reversing part of
> 1d64b655dc083df also) fixes this particular problem on 2.6.39.4,
> 3.0.8, and 3.1.

I am not sure how this commit could cause your "no video" issue...
Are you hibernating from text console or X? Can you try plugging in USB
keyboard and see if you are getting input? What about ssh into the box?

Thanks.

-- 
Dmitry
