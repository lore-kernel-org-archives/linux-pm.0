From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 14:51:37 +0200
Message-ID: <200707051451.38497.rjw__19173.4959990301$1183639573$gmane$org@sisk.pl>
References: <E1I63Nv-0006Z9-00@dorka.pomaz.szeredi.hu>
	<Pine.LNX.4.44L0.0707041139100.25704-100000@netrider.rowland.org>
	<18060.15630.812698.367707@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <18060.15630.812698.367707@cargo.ozlabs.ibm.com>
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
Cc: mjg59@srcf.ucam.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

On Thursday, 5 July 2007 02:36, Paul Mackerras wrote:
> Alan Stern writes:
> 
> > Remember what I wrote a few minutes ago about khubd and ksuspend_usbd
> > wanting to resume devices during a system suspend transition?  This is
> > exactly what happens when those threads aren't frozen.
> 
> So, I wonder why I don't see that error on my powerbook?

Because you have only one CPU running while your suspend code is being
executed?

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
