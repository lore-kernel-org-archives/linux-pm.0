From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 0/3] [idled]: Idle Cycle Injector for power
	capping
Date: Tue, 20 Apr 2010 22:08:55 -0700
Message-ID: <20100420220855.4619256b__12615.2862831534$1271826506$gmane$org@infradead.org>
References: <20100413234902.29004.41655.stgit@bumblebee1.mtv.corp.google.com>
	<1271317886.32749.69.camel@laptop>
	<h2u4352991a1004191020q8200399oc8e9f7d8dee934bf@mail.gmail.com>
	<1271703701.1676.235.camel@laptop>
	<20100420045038.GB2915@dirshya.in.ibm.com>
	<k2y4352991a1004201052lbef1fd73g714d527e872162fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <k2y4352991a1004201052lbef1fd73g714d527e872162fd@mail.gmail.com>
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
Cc: ranjitm@google.com, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, csadler@google.com, kenchen@google.com, dawnchen@google.com, linux-pm@lists.linux-foundation.org, mingo@elte.hu, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 20 Apr 2010 10:52:58 -0700
Salman Qazi <sqazi@google.com> wrote:

> For improving power savings in the non-SMT case, as Arjan suggested, I
> will make the changes for heuristically aligning the injection on
> multiple cores.  This will not be perfect, but then because it's a
> power optimization, it doesn't have to always work.  I presume that
> this works best when done according to the CPU hierarchy?  That is, it
> is more beneficial to idle an entire socket than the same number of
> cores on different sockets?

not really; at least not for Intel CPUs.
The problem is that due to the cache coherency, as long as one cpu in
the system is awake, the memory controllers etc cannot go into a sleep
mode...

I would not be surprised if AMD has the same behavior... or anyone else
with an integrated memory controller for that matter.


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
