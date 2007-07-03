From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 03 Jul 2007 15:49:08 +1000
Message-ID: <1183441748.10386.75.camel__3469.78782113201$1183442038$gmane$org@localhost.localdomain>
References: <20070703042916.GA17240@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070703042916.GA17240@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2007-07-03 at 05:29 +0100, Matthew Garrett wrote:
> Suspend to RAM on a machine with / on a fuse filesystem turns out to be 
> a screaming nightmare - either the suspend fails because syslog (for 
> instance) can't be frozen, or the machine deadlocks for some other 
> reason I haven't tracked down. We could "fix" fuse, or alternatively we 
> could do what we do for suspend to RAM on other platforms (PPC and APM) 
> and just not use the freezer.
> 
> Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

(And with much pleasure :-)

Cheers,
Ben.
