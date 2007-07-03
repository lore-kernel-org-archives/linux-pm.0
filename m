From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 15:12:58 +0200
Message-ID: <200707031512.59194.rjw@sisk.pl>
References: <20070703042916.GA17240@srcf.ucam.org>
	<1183448224.12649.14.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183448224.12649.14.camel@localhost>
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
To: Romano Giannetti <romanol@upcomillas.es>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, 3 July 2007 09:37, Romano Giannetti wrote:
> On Tue, 2007-07-03 at 05:29 +0100, Matthew Garrett wrote:
> > or alternatively we  could do what we do for suspend to RAM on other
> > platforms (PPC and APM) and just not use the freezer.
> 
> As a data point, I am running with this patch on top of 2.6.21.2 the
> last 3+ weeks, with an average of 5/6 STR cycles a day, and had no
> problems at all. (Sony vaio pcg-fx701). Just normal work, I didn't try
> to stress the thing, but I have quite a few times suspended/resumed over
> a big compile without a glitch.
> 
> What are the risks of this patch supposed to be?

See https://lists.linux-foundation.org/pipermail/linux-pm/2007-June/012847.html

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
