From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/3] [kidled]: introduce kidled.
Date: Thu, 15 Apr 2010 09:46:51 +0200
Message-ID: <1271317611.32749.68.camel__6027.59500402517$1271317718$gmane$org@laptop>
References: <20100413234902.29004.41655.stgit@bumblebee1.mtv.corp.google.com>
	<20100414000823.29004.98991.stgit@bumblebee1.mtv.corp.google.com>
	<87fx2y9xdn.fsf@basil.nowhere.org>
	<o2y4352991a1004140841w7f37b84cnedcd91c2638a07ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <o2y4352991a1004140841w7f37b84cnedcd91c2638a07ea@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Salman Qazi <sqazi@google.com>
Cc: dawnchen@google.com, csadler@google.com, linux-kernel@vger.kernel.org, ranjitm@google.com, Andi Kleen <andi@firstfloor.org>, kenchen@google.com, linux-pm@lists.linux-foundation.org, mingo@elte.hu, akpm@linux-foundation.org, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2010-04-14 at 08:41 -0700, Salman Qazi wrote:
> 
> To capture all the quantities for a CPU atomically, they must be read
> on the CPU.  Basically, reading them on that CPU prevents them from
> changing as we read them.
> 
> Also, if the CPU is idle (injected or otherwise), the quantities won't
> get updated. 

Who cares? by the time they reach userspace they've changed anyway.
