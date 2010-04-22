From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/3] [idled]: Idle Cycle Injector for power
	capping
Date: Thu, 22 Apr 2010 10:21:53 +0200
Message-ID: <1271924513.1776.315.camel__38575.6186944947$1271925082$gmane$org@laptop>
References: <20100413234902.29004.41655.stgit@bumblebee1.mtv.corp.google.com>
	<1271317886.32749.69.camel@laptop>
	<v2v8bb80c381004211832o88258fdez8e640ad9a45d11c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <v2v8bb80c381004211832o88258fdez8e640ad9a45d11c0@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mike Chan <mike@android.com>
Cc: Salman <sqazi@google.com>, akpm@linux-foundation.org, dawnchen@google.com, csadler@google.com, linux-kernel@vger.kernel.org, ranjitm@google.com, kenchen@google.com, linux-pm@lists.linux-foundation.org, mingo@elte.hu, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2010-04-21 at 18:32 -0700, Mike Chan wrote:
> 
> I may have missed this on lkml but are there any on-going community
> efforts to power aware scheduling?
> 
Well, mostly targeting load-balancing, which I gather is kinda useless
for android seeing that it runs on UP hardware.

But yeah, both IBM and Intel have contributed significant work in this
area.
