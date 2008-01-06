From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Acquire device locks on suspend
Date: Sun, 6 Jan 2008 23:24:14 +0100
Message-ID: <200801062324.15960.rjw__27021.6203564361$1199658382$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0801061710140.19222-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0801061710140.19222-100000@netrider.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Sunday, 6 of January 2008, Alan Stern wrote:
> On Sun, 6 Jan 2008, Rafael J. Wysocki wrote:
> 
> > On Sunday, 6 of January 2008, Alan Stern wrote:
> 
> > Still, shouldn't we fail the removal of the device apart from giving the
> > warning?
> 
> We can't.  device_del() can't fail -- it returns void.  Besides, how 
> can a driver hope to deal with an unregistration failure?

Well, right.

Still, our present approach doesn't seem to be correct overall.  For example,
I think we should prevent a suspend from happening while a device is being
removed.

Rafael
