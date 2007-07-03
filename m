From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 15:09:39 +0200
Message-ID: <200707031509.39683.rjw__2987.39660433984$1183467783$gmane$org@sisk.pl>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707030813.53481.oliver@neukum.org>
	<20070703121313.GA21318@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070703121313.GA21318@srcf.ucam.org>
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
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, 3 July 2007 14:13, Matthew Garrett wrote:
> On Tue, Jul 03, 2007 at 08:13:53AM +0200, Oliver Neukum wrote:
> 
> > Only if you want to audit all character devices' read() and write()
> > methods for races against suspend().
> > / on fuse is a bad idea.
> 
> Any driver that assumes that userspace will be frozen during suspend has 
> been broken forever. That behaviour has never been guaranteed.

Can we please fix those drivers _first_, then?

Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
