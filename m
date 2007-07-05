From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 10:36:30 +1000
Message-ID: <18060.15630.812698.367707__41098.7486983233$1183596437$gmane$org@cargo.ozlabs.ibm.com>
References: <E1I63Nv-0006Z9-00@dorka.pomaz.szeredi.hu>
	<Pine.LNX.4.44L0.0707041139100.25704-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707041139100.25704-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: mjg59@srcf.ucam.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

Alan Stern writes:

> Remember what I wrote a few minutes ago about khubd and ksuspend_usbd
> wanting to resume devices during a system suspend transition?  This is
> exactly what happens when those threads aren't frozen.

So, I wonder why I don't see that error on my powerbook?

Paul.
