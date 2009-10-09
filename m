From: Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [BUG?] how should we handle KEY_SLEEP with Hibernation?
Date: Fri, 09 Oct 2009 10:38:26 +0800
Message-ID: <1255055906.5810.99.camel__39651.2275365696$1255055995$gmane$org@falcon>
Reply-To: wuzhangjin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>, HAL Devel <hal@lists.freedesktop.org>, loongson-dev <loongson-dev@googlegroups.com>
Cc: liushiwei@gmail.com
List-Id: linux-pm@vger.kernel.org

Hello,

A user reported such a problem on YeeLoong laptop:

He tried to make his system go into hibernation, so he pressed "Fn +
F1"(KEY_SLEEP), but the system is VERY busy, he got NO(very slow)
response, so, he tried "Fn + F1" again and again, at last, the system
hibernated, and then, he tried to resume it from hibernation, the system
booted normally but after entering into the system, it responded the
not-handled KEY_SLEEPs, and went into hibernation again and again until
there was no KEY_SLEEP left.

I guess this is not a YeeLoong-specific problem, perhaps we can try to
make HAL(hald-addon-input) only handle ONE KEY_SLEEP event in a fixed
time range to avoid this problem, or handle it in kernel-space?

what about your ideas?

Regards,
	Wu Zhangjin
