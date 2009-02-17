From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFD] Automatic suspend
Date: Tue, 17 Feb 2009 14:51:41 +0000
Message-ID: <20090217145141.GA26158__18555.5973592729$1234882455$gmane$org@srcf.ucam.org>
References: <f73f7ab80902161208h12837d4ex1d28d55d031d5d71@mail.gmail.com>
	<13B9B4C6EF24D648824FF11BE896716203771DD01B@dlee02.ent.ti.com>
	<20090216145948.6fea81c3@infradead.org>
	<200902170019.40599.rjw@sisk.pl>
	<20090216232329.GA15678@srcf.ucam.org>
	<20090217142001.GB12378@bulgaria.corp.google.com>
	<20090217064630.688bf639@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090217064630.688bf639@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Kyle Moffett <kyle@moffetthome.net>, Brian Swetland <swetland@google.com>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 17, 2009 at 06:46:30AM -0800, Arjan van de Ven wrote:

> actually with powertop... on the open source side things are actually
> won. It took all of 6 months...
> I don't see that as a valid excuse. In fact, if this kind of solution
> makes real userspace scheduled timers to be missed then I consider it a
> serious functionality misfeature.

Remember that Android has an open marketplace designed to appeal to Java 
programmers - users are going to end up downloading code from there and 
then blaming the platform if their battery life heads towards zero. I 
think "We can't trust our userland not to be dumb" is a valid concern.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
