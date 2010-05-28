From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 8/8] intel_idle: create a native cpuidle
 driver for select intel processors
Date: Fri, 28 May 2010 10:28:30 -0700
Message-ID: <1275067710.4507.194.camel__44378.8212528036$1275067758$gmane$org@localhost>
References: <1274928151-30919-1-git-send-email-lenb@kernel.org>
	<e099975ca65a7f6ac7f8bc3fee84d3e03893aa31.1274926772.git.len.brown@intel.com>
	<198450ec1600d9a7f55270dd4d44d6b55bc5b184.1274926772.git.len.brown@intel.com>
	<87ljb5l9d5.fsf@deeprootsystems.com>
	<20100527072207.2e783b1e@infradead.org>
	<87ocg1jts7.fsf@deeprootsystems.com>
	<alpine.LFD.2.00.1005272009490.24823@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1005272009490.24823@localhost.localdomain>
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
Cc: linux-pm@lists.linux-foundation.org, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2010-05-27 at 20:22 -0400, Len Brown wrote:
> > >> >  drivers/idle/intel_idle.c       |  446
> 
> > >> Any reason this arch-specific driver needs to be in drivers/idle
> > >> instead of under a platform specific dir like arch/x86?
> 
> > To me that would be much less convenient as I expect to maintain my
> > platform-specific CPUidle driver along with the rest of my
> > platform-specific code.
> 
> I guess the reason is conveneince of the maintainer (me).

OK, fair enough.

At least that makes more sense to me than "keeping all users in one
place."

Kevin
