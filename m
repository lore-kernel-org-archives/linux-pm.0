From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] swsusp: Do not use pm_ops
Date: Thu, 3 May 2007 14:53:35 +0200
Message-ID: <200705031453.36459.rjw__49072.8840035901$1178196603$gmane$org@sisk.pl>
References: <200705022213.35831.rjw@sisk.pl>
	<1178194332.13233.98.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1178194332.13233.98.camel@johannes.berg>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday, 3 May 2007 14:12, Johannes Berg wrote:
> On Wed, 2007-05-02 at 22:13 +0200, Rafael J. Wysocki wrote:
> 
> >  extern void swsusp_unset_page_free(struct page *);
> >  extern unsigned long get_safe_page(gfp_t gfp_mask);
> 
> > +void hibernation_set_ops(struct hibernation_ops *ops);
> 
> > +extern int hibernate(void);
> 
> You could add an extern to hibernation_set_ops for consistency :) Not
> that I really care.

Will add, thanks.

Rafael
