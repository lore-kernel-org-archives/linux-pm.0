From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH -v5 0/6] notifier error injection
Date: Wed, 4 Jul 2012 19:07:18 +0900
Message-ID: <CAC5umyhLEp_T1BF6LRNLBMcO-QEE6_hTLL1PAd=65yYRBg3rpQ@mail.gmail.com>
References: <1341035970-20490-1-git-send-email-akinobu.mita@gmail.com>
	<20120703134120.dc89c7ae.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120703134120.dc89c7ae.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michael Ellerman <michael@ellerman.id.au>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, =?ISO-8859-1?Q?Am=E9rico_Wang?= <xiyou.wangcong@gmail.com>, linux-pm@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pm@vger.kernel.org

2012/7/4 Andrew Morton <akpm@linux-foundation.org>:
> On Sat, 30 Jun 2012 14:59:24 +0900
> Akinobu Mita <akinobu.mita@gmail.com> wrote:
>
>> This provides kernel modules that can be used to test the error handling
>> of notifier call chain failures by injecting artifical errors to the
>> following notifier chain callbacks.
>
> No updates to Documentation/fault-injection/?

Thanks for the remainder.
I'll prepare to add a document to it.
