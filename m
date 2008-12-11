From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH -suspend] Hibernate: Replace unnecessary
 evaluation of pfn_to_page()
Date: Thu, 11 Dec 2008 18:28:21 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812111827530.27190__42630.0046769485$1229040446$gmane$org@localhost.localdomain>
References: <200812080052.49604.rjw@sisk.pl> <20081208072657.GA2418@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <20081208072657.GA2418@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@suse.cz>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


On Mon, 8 Dec 2008, Pavel Machek wrote:

> On Mon 2008-12-08 00:52:49, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > Subject: Hibernate: Replace unnecessary evaluation of pfn_to_page()
> > 
> > Replace one evaluation of pfn_to_page() in copy_data_pages() with
> > the value of a local variable containing the right number already.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Acked-by: Pavel Machek <pavel@suse.cz>

applied to suspend branch

--
Len Brown, Intel Open Source Technology Center
