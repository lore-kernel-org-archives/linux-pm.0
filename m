From: Corrado Zoccolo <czoccolo@gmail.com>
Subject: Re: [PATCH] cpuidle: menu governor: reduce latency on
	exit
Date: Fri, 24 Jul 2009 17:41:26 +0200
Message-ID: <4e5e476b0907240841y183a4c08r3abf3d4fb7489284__25672.3861246885$1248450374$gmane$org@mail.gmail.com>
References: <200907191659.47179.czoccolo@gmail.com>
	<20090723150517.fbbd03dc.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090723150517.fbbd03dc.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, abelay@novell.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi Andrew,
the expected effect is to reduce processor wakeup latency from sleep (C-states).

We are speaking of few hundreds of cycles reduction out of a several
microseconds latency (determined by the hardware transition), so it is
difficult to measure.

Corrado

On Fri, Jul 24, 2009 at 12:05 AM, Andrew
Morton<akpm@linux-foundation.org> wrote:
> On Sun, 19 Jul 2009 16:59:46 +0200
> Corrado Zoccolo <czoccolo@gmail.com> wrote:
>
>> This patch moves the state residency accounting and statistics
>> computation off the hot exit path.
>> On exit, the need to recompute statistics is recorded, and new
>> statistics will be computed when menu_select is called again.
>>
>
> Was there any observed and/or measured effect as a result of this patch?
>
> If so, please send a description of that effect, thanks.
>
>



-- 
__________________________________________________________________________

dott. Corrado Zoccolo                          mailto:czoccolo@gmail.com
PhD - Department of Computer Science - University of Pisa, Italy
--------------------------------------------------------------------------
