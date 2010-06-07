From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] pm_qos: make update_request callable from
 interrupt context
Date: Mon, 7 Jun 2010 09:37:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006070934410.14424-100000@netrider.rowland.org>
References: <1275916241.2849.21.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275916241.2849.21.camel@mulgrave.site>
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
Cc: florian@mickler.org, pm list <linux-pm@lists.linux-foundation.org>, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Mon, 7 Jun 2010, James Bottomley wrote:

> > +int pm_qos_add_notifier_nonblocking(int pm_qos_class, struct notifier_block *notifier)
> 
> Rightly or wrongly, the notifier people use atomic not nonblocking, so
> we should really stick with it to avoid confusion.

I'm afraid that's my fault.  I used "atomic" because it's shorter and
punchier than "nonblocking".  It refers to the context in which the
notifier chain may be called.

Alan Stern
