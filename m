From: Paul Mackerras <paulus@samba.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 09:40:44 +1000
Message-ID: <18058.56956.595143.15424__33891.0528379076$1183519493$gmane$org@cargo.ozlabs.ibm.com>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707031307.41366.oliver@neukum.org>
	<1183463053.10386.112.camel@localhost.localdomain>
	<200707031355.51028.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707031355.51028.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-pm@lists.linux-foundation.org, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, mjg59@srcf.ucam.org
List-Id: linux-pm@vger.kernel.org

Oliver Neukum writes:

> That's why we have the problem of freezing the kernel threads or not.

That problem is a symptom of the deeper conceptual problem, as is the
problem with FUSE.

> You want to have all that pain for fuse?

I'd certainly rather get the drivers right, and maybe have an
occasional deadlock if I miss something, than have a GUARANTEED
deadlock every time I suspend with a FUSE filesystem mounted (which is
pretty much every time, since I use encfs regularly).

Paul.
