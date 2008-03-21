From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 2)
Date: Fri, 21 Mar 2008 01:26:31 +0100
Message-ID: <200803210126.32683.rjw__7387.19225996665$1206059476$gmane$org@sisk.pl>
References: <200803210101.04706.rjw@sisk.pl>
	<1206058863.16475.165.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1206058863.16475.165.camel@johannes.berg>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 21 of March 2008, Johannes Berg wrote:
> 
> > + * All of the above callbacks, except for @complete(), return error codes.
> > + * However, the error codes returned by the resume operations, @resume(),
> > + * @thaw(), and @restore(), are only printed in the system logs, since the PM
> > + * core cannot do anything else about them.
> 
> Why bother and not just make them return void, the error printing can
> most likely be done much much better in the callback since that possibly
> has information on why it failed.
> 
> > + * All of the above callbacks, return error codes, but the error codes returned
> > + * by the resume operations, @resume_noirq(), @thaw_noirq(), and
> > + * @restore_noirq(), are only printed in the system logs, since the PM core
> > + * cannot do anything else about them.
> 
> Same here, of course.

The errors returned are used by TRACE_RESUME(), for example.

Well, perhaps the comments should be changed instead. :-)

Thanks,
Rafael
