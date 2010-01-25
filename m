From: Frans Pop <elendil@planet.nl>
Subject: Re: Warnings about tasks on CPU 1 during STR
Date: Mon, 25 Jan 2010 14:52:33 +0100
Message-ID: <201001251452.34237.elendil__22246.4497354396$1264427730$gmane$org@planet.nl>
References: <201001250542.08642.elendil@planet.nl>
	<1264423859.4283.1725.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1264423859.4283.1725.camel@laptop>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday 25 January 2010, Peter Zijlstra wrote:
> On Mon, 2010-01-25 at 05:42 +0100, Frans Pop wrote:
> > All the "Task X is on cpu 1" messages (76 in total) are new. Bug or
> > intentional? As it is a warning, I suspect a bug.
>
> http://lkml.org/lkml/2010/1/21/175

Thanks Peter, that fixes it.

I've a small cleanup patch for the warning that I'll send separately.

Cheers,
FJP
