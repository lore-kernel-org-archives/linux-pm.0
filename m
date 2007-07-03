From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 00:43:32 +0200
Message-ID: <200707040043.32995.rjw__30082.0218668834$1183502445$gmane$org@sisk.pl>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707032332.49694.rjw@sisk.pl>
	<1183498555.3388.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183498555.3388.14.camel@localhost.localdomain>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, 3 July 2007 23:35, Benjamin Herrenschmidt wrote:
> On Tue, 2007-07-03 at 23:32 +0200, Rafael J. Wysocki wrote:
> > 
> > Still, do you really think that we're ready to drop it _right_ _now_
> > (I'm
> > referring to suspend only) and if so than on what basis (except that
> > you
> > don't like it, which falls short of being a techical argument)?
> 
> Works fine for me without it ;-)

Yeah, that makes sense. ;-)

Still, someone needs to take care of bug reports from unlucky people and I
wouldn't like to increase the number of these by doing such a high-level change
without any preparations ...

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
