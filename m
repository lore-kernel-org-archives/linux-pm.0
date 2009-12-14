From: Andi Kleen <andi@firstfloor.org>
Subject: Re: RFC: A proposal for power capping through forced
	idle in the Linux Kernel
Date: Tue, 15 Dec 2009 00:21:07 +0100
Message-ID: <876389xhuk.fsf__42024.8076822192$1260833235$gmane$org@basil.nowhere.org>
References: <4352991a0912141511k7f9b8b79y767c693a4ff3bc2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4352991a0912141511k7f9b8b79y767c693a4ff3bc2b@mail.gmail.com>
	(Salman Qazi's message of "Mon, 14 Dec 2009 15:11:47 -0800")
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
Cc: Michael Rubin <mrubin@google.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Taliver Heath <taliver@google.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Salman Qazi <sqazi@google.com> writes:
>
> We'd like to get as much of our stuff upstream as we can.  Given that
> this is a somewhat sizable chunk of work, it would be impolite of me
> to just send out a bunch of patches without hearing the concerns of
> the community.  What are your thoughts on our design and what do we
> need to change to get this to be more acceptable to the community?  I
> also would like to know if there are any existing pieces of
> infrastructure that this can utilize.

There were a lot of discussions on this a few months ago in context
of the ACPI 4 "power aggregator" which is a similar (perhaps
slightly less sophisticated) concept. 

While there was a lot of talk about teaching the scheduler about this 
the end result was just a driver which just starts real time threads
and then idles in them. This is in current mainline.

It might be a good idea to review these discussions in the archives.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
