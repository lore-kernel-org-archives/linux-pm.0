From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v5 2/5] driver core: Functional dependencies tracking
 support
Date: Sun, 13 Nov 2016 18:34:13 +0100
Message-ID: <20161113173413.GB9598@wunner.de>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <13957403.ZrB4mMbICz@vostro.rjw.lan>
 <2715729.9U1nlcpFb3@vostro.rjw.lan>
 <20161107213954.GI1764@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:55929 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933841AbcKMRdB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Nov 2016 12:33:01 -0500
Content-Disposition: inline
In-Reply-To: <20161107213954.GI1764@wotan.suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Lars-Peter Clausen <lars@metafoo.de>, Andrzej Hajda <a.hajda@samsung.com>

On Mon, Nov 07, 2016 at 10:39:54PM +0100, Luis R. Rodriguez wrote:
> On Mon, Oct 10, 2016 at 02:51:04PM +0200, Rafael J. Wysocki wrote:
> > One of the actions carried out by device_link_add() is to reorder
> > the lists used for device shutdown and system suspend/resume to
> > put the consumer device along with all of its children and all of
> > its consumers (and so on, recursively) to the ends of those lists
> > in order to ensure the right ordering between all of the supplier
> > and consumer devices.
> 
> There's no explanation as to why this order is ensured to be
> correct, I think its important to document this. From our discussions
> at Plumbers it seems the order is ensured due to the fact that order
> was already implicitly provided through platform firmware (ACPI
> enumeration is one), adjusting order on the dpm list is just shuffling
> order between consumer / provider, but nothing else.

ACPI specifies a hierarchy and the order on the dpm_list and
devices_kset is such that children are behind their parent.

A device link specifies a dependency that exists in addition
to the hierarchy, hence consumers need to be moved behind
their supplier.  And not only the consumers themselves but
also recursively their children and consumers. Essentially
the entire subtree is moved to the back.  That happens in
device_reorder_to_tail() in patch 2.

If another device is enumerated which acts as a supplier to
an existing other supplier, that other supplier and all its
dependents are moved behind the newly enumerated device,
and so on.

That is provably correct so long as no loops are introduced
in the dependency graph.  That is checked by device_is_dependent(),
which is called from device_link_add(), and the addition of the
link is aborted if a loop is detected.

Best regards,

Lukas
