From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [BUG?] how should we handle KEY_SLEEP with
	Hibernation?
Date: Fri, 9 Oct 2009 09:20:09 -0700
Message-ID: <20091009162008.GA1092__41910.6694906533$1255105382$gmane$org@core.coreip.homeip.net>
References: <1255055906.5810.99.camel@falcon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1255055906.5810.99.camel@falcon>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Wu Zhangjin <wuzhangjin@gmail.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, loongson-dev <loongson-dev@googlegroups.com>, HAL Devel <hal@lists.freedesktop.org>, liushiwei@gmail.com
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 09, 2009 at 10:38:26AM +0800, Wu Zhangjin wrote:
> Hello,
> 
> A user reported such a problem on YeeLoong laptop:
> 
> He tried to make his system go into hibernation, so he pressed "Fn +
> F1"(KEY_SLEEP), but the system is VERY busy, he got NO(very slow)
> response, so, he tried "Fn + F1" again and again, at last, the system
> hibernated, and then, he tried to resume it from hibernation, the system
> booted normally but after entering into the system, it responded the
> not-handled KEY_SLEEPs, and went into hibernation again and again until
> there was no KEY_SLEEP left.
> 
> I guess this is not a YeeLoong-specific problem, perhaps we can try to
> make HAL(hald-addon-input) only handle ONE KEY_SLEEP event in a fixed
> time range to avoid this problem, or handle it in kernel-space?
> 

Userspace solution please. The kernel is responsible for handlig issues
like mechanical jitter but the decision of ignoring certain key presses
for a period of time is a policy matter and thus belongs to userspace.

-- 
Dmitry
