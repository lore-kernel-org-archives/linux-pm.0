From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to
	RAM pathway
Date: Fri, 06 Jul 2007 08:38:15 +1000
Message-ID: <1183675095.3388.72.camel@localhost.localdomain>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<200707051024.23528.oliver@neukum.org>
	<E1I6Mtu-000058-00@dorka.pomaz.szeredi.hu>
	<200707051048.46202.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707051048.46202.oliver@neukum.org>
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
Cc: mjg59@srcf.ucam.org, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


> There is that.
> 
> OK, bite the bullet. Tasks involved in fuse are special. Give them a flag
> and teach the freezer to put them on ice only after all other task are
> frozen. In a way they are kernel, there's no use denying that.

Yet another ugly hack to work around the fact that the freezer cannot
work reliably ... yuck

Why not spend that energy fixing drivers to properly block requests
instead ?

Ben.
