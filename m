From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 10:29:29 +1000
Message-ID: <18060.15209.274437.471074__41681.5868382857$1183596425$gmane$org@cargo.ozlabs.ibm.com>
References: <20070703211227.GA28758@srcf.ucam.org>
	<E1I666o-0006wu-00@dorka.pomaz.szeredi.hu>
	<200707041703.21808.oliver@neukum.org>
	<200707041717.05149.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707041717.05149.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: mjg59@srcf.ucam.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki writes:

> They will not trigger 100% of the time, but sporadically and generally at
> random.
> 
> At least the freezer problems are reproducible. ;-)

Our experience with powermacs has been that it isn't actually all that
hard to get it right for the drivers you care about.

Paul.
