From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Update device power management
	document
Date: Thu, 18 Mar 2010 22:38:55 +0100
Message-ID: <201003182238.55618.rjw__49085.3491276086$1268948245$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1003181135200.1665-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1003181135200.1665-100000@iolanthe.rowland.org>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 18 March 2010, Alan Stern wrote:
> Rafael:
> 
> Here's my updated version of your patch.  It's meant as a replacement,
> rather than an additional patch.  I used much of your text but I also
> altered a lot.  And the new documentation describes the way things will
> be after Dominik Brodowski's change is added, rather than the way
> things are now.

Thanks!

I agree with all of the changes you made.

> Attribution of authorship for changes like this is difficult; the 
> existing conventions don't make allowance for patches with multiple 
> authors.  You'll have to figure out the right way to handle it.

I think I'll covert your version into a patch on top of mine for this purpose.

That's a bit artificial, but it will reflect who did what correctly, which also
is important (and the Randy's "Reviewed-by" for my patch will be preserved this
way).

Rafael
