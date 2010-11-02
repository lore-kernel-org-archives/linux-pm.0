From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 5/5] intel_idle: do not use the LAPIC timer
 for ATOM C2
Date: Tue, 2 Nov 2010 02:21:09 +0100
Message-ID: <20101102011956.GA2648@ucw.cz>
References: <c8381cc3d8a9cc6c80f65bf60863c776651f245c.1288127069.git.len.brown@intel.com>
	<c25d29952b2a8c9aaf00e081c9162a0e383030cd.1288127069.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <c25d29952b2a8c9aaf00e081c9162a0e383030cd.1288127069.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue 2010-10-26 17:07:34, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> If we use the LAPIC timer during ATOM C2 on
> some nvidia chisets, the system stalls.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=21032

> @@ -302,7 +302,7 @@ static int intel_idle_probe(void)
>  
>  	case 0x1C:	/* 28 - Atom Processor */
>  	case 0x26:	/* 38 - Lincroft Atom Processor */
> -		lapic_timer_reliable_states = (1 << 2) | (1 << 1); /* C2, C1 */
> +		lapic_timer_reliable_states = (1 << 1); /* C1 */
>  		cpuidle_state_table = atom_cstates;

That comment should probably go here, along with list of chipsets.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
