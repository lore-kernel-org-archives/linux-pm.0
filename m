From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/3] pm_qos: get rid of the allocation in
	pm_qos_add_request()
Date: Fri, 2 Jul 2010 00:38:20 +0200
Message-ID: <201007020038.20254.rjw__789.158643647347$1278024112$gmane$org@sisk.pl>
References: <1277746434.10879.191.camel@mulgrave.site>
	<201007020023.13815.rjw@sisk.pl>
	<1278023439.2813.388.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1278023439.2813.388.camel@mulgrave.site>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Takashi Iwai <tiwai@suse.de>, netdev@vger.kernel.org, linux-pm@lists.linux-foundation.org, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Friday, July 02, 2010, James Bottomley wrote:
> On Fri, 2010-07-02 at 00:23 +0200, Rafael J. Wysocki wrote:
> > I would apply this one too, but I need a final changelog for it.  Care to send?
> 
> How about:
> 
> All current users of pm_qos_add_request() have the ability to supply the
> memory required by the pm_qos routines, so make them do this and
> eliminate the kmalloc() with pm_qos_add_request().  This has the double
> benefit of making the call never fail and allowing it to be called from
> atomic context.
> 
> + signoffs

OK

I'll apply it shortly.

Rafael
