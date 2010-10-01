From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH 1/2] PERF(kernel): Cleanup power events
Date: Fri, 01 Oct 2010 09:51:54 -0700
Message-ID: <4CA611AA.2010209__643.760085995559$1285952055$gmane$org@linux.intel.com>
References: <1285945464-10884-1-git-send-email-trenn@suse.de>
	<4CA60385.6040405@linux.intel.com> <20101001155823.GD5338@nowhere>
	<201010011829.53523.trenn@suse.de> <20101001164736.GE5338@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101001164736.GE5338@nowhere>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, jean.pihet@newoldbits.com, Steven Rostedt <rostedt@goodmis.org>, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, linux-pm@lists.linux-foundation.org, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

  On 10/1/2010 9:47 AM, Frederic Weisbecker wrote:

>
>> I'd like to have a decision how this will get cleaned up!
>
> I know. Trace event are not supposed to be ABI, but once a
> tool gets broken, the reality catches up.
>
> Since Arjan nacks your last solution, we need to find
> something.

btw I do not hate the new names; they are much nicer, I completely agree 
with that.
... just that breaking existing apps is something I'm very unhappy with 
for something that is
as cosmetic as a name.
