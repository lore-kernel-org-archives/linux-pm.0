From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [RFC][PATCH -mm] swsusp: use less memory during
	resume
Date: Thu, 20 Apr 2006 12:05:41 +0200
Message-ID: <200604201205.42421.rjw@sisk.pl>
References: <200604181319.47400.rjw@sisk.pl> <200604191005.41701.rjw@sisk.pl>
	<200604191831.45936.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============80666646890802185=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604191831.45936.ncunningham@cyclades.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Linux PM <linux-pm@osdl.org>, linux-pm@lists.osdl.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============80666646890802185==
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Wednesday 19 April 2006 10:31, Nigel Cunningham wrote:
> On Wednesday 19 April 2006 18:05, Rafael J. Wysocki wrote:
> > On Tuesday 18 April 2006 15:07, Nigel Cunningham wrote:
> > > On Tuesday 18 April 2006 21:19, Rafael J. Wysocki wrote:
}-- snip --{ 
> > > Haven't looked at the patch itself, but this sounds like a great idea. I
> > > wonder though, won't the 50% limit still apply, because you'll still have
> > > to make an atomic copy to start with (unless you figure out which pages
> > > aren't going to change and therefore don't need to be atomically copied)?
> >
> > You are right, and I'm going to figure out which pages won't change.  I
> > think I have some good candidates. ;-)
> 
> LRU by any chance? :)

Generally yes, but not all of them.  First of all pages that are mapped by
frozen processes.  Maybe some others too, but that will have to be handled
with care. ;-)

Greetings,
Rafael

--===============80666646890802185==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============80666646890802185==--
