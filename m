From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [PATCH 3/3] pm_qos: get rid of the allocation in
 pm_qos_add_request()
Date: Thu, 01 Jul 2010 17:30:39 -0500
Message-ID: <1278023439.2813.388.camel__43451.6627029099$1278023582$gmane$org@mulgrave.site>
References: <1277746434.10879.191.camel@mulgrave.site>
	<1277747088.10879.201.camel@mulgrave.site>
	<20100629043954.GB6250@gvim.org> <201007020023.13815.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201007020023.13815.rjw@sisk.pl>
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
Cc: Takashi Iwai <tiwai@suse.de>, netdev@vger.kernel.org, linux-pm@lists.linux-foundation.org, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2010-07-02 at 00:23 +0200, Rafael J. Wysocki wrote:
> I would apply this one too, but I need a final changelog for it.  Care to send?

How about:

All current users of pm_qos_add_request() have the ability to supply the
memory required by the pm_qos routines, so make them do this and
eliminate the kmalloc() with pm_qos_add_request().  This has the double
benefit of making the call never fail and allowing it to be called from
atomic context.

+ signoffs

James
