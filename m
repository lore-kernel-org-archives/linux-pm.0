From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch 2.6.21-rc5-git 0/3] x86_pc and ACPI support
	/sys/devices/.../wakeup
Date: Fri, 6 Apr 2007 02:05:10 +0200
Message-ID: <200704060205.10613.rjw@sisk.pl>
References: <200704051248.40745.david-b@pacbell.net>
	<200704051648.56288.david-b@pacbell.net>
	<20070405235422.GA12995@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070405235422.GA12995@srcf.ucam.org>
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
To: Matthew Garrett <mjg59@srcf.ucam.org>, David Brownell <david-b@pacbell.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday, 6 April 2007 01:54, Matthew Garrett wrote:
> On Thu, Apr 05, 2007 at 04:48:55PM -0700, David Brownell wrote:
> =

> > That system happens to be 32 bits, but a similar one is 64 bits ...
> > has vbetool been made to work on x86_64 yet?
> =

> Yes, the latest version uses libx86 to execute BIOS code, which includes =

> x86emu on machines which don't have vm86(). =

> http://www.codon.org.uk/~mjg59/vbetool/ has the current code.

Or look at http://en.opensuse.org/s2ram (it uses vbetool internally ;-)).
