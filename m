From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 13:02:58 +0200
Message-ID: <200707041303.00016.oliver__6224.19997021115$1183547087$gmane$org@neukum.org>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707041253.33154.oliver@neukum.org>
	<18059.32169.906914.258802@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <18059.32169.906914.258802@cargo.ozlabs.ibm.com>
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
To: Paul Mackerras <paulus@samba.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Am Mittwoch, 4. Juli 2007 schrieb Paul Mackerras:
> Oliver Neukum writes:
> 
> > They can't. Device specific protocols are known to the drivers only.
> > The fact remains, remove the freezer and you need to go through
> > all drivers.
> 
> The freezer does not actually mean that you don't have to get the
> drivers right, because kernel threads can issue I/O requests.

Kernel threads do not issue requests for the hell of it. And yes,
kernel threads must be aware of suspension. Threads are few,
drivers many.

	Oliver
