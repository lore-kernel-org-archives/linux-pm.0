From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Mon, 9 Jul 2007 13:56:44 +0200
Message-ID: <200707091356.45486.rjw__31314.3196319745$1183981844$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0707081619090.11049-100000@netrider.rowland.org>
	<200707090852.03429.oliver@neukum.org>
	<1183972449.5961.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183972449.5961.28.camel@localhost.localdomain>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday, 9 July 2007 11:14, Benjamin Herrenschmidt wrote:
> On Mon, 2007-07-09 at 08:52 +0200, Oliver Neukum wrote:
> > Am Sonntag, 8. Juli 2007 schrieb Benjamin Herrenschmidt:
> > > Another issue that's been a problem forever with suspend is the
> > > synchronous request_firmware interface. Lots of drivers do that in
> > > resume() which will generally not work.
> > 
> > Unfortunately yes they do. We now have the notifier chains, which
> > can be used. Firmware, especially if it is large, must be requested
> > while the system is still fully functional and paging will work.
> > 
> > Asynchronocity will not help much because the devices must work
> > after resumingand delaying that will not help with respect to needing
> > devices to get at the firmware.
> 
> True, pre-loading is the best approach.

Agreed.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
