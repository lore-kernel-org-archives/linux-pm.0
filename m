From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Mon, 09 Jul 2007 19:14:09 +1000
Message-ID: <1183972449.5961.28.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0707081619090.11049-100000@netrider.rowland.org>
	<1183929708.3388.306.camel@localhost.localdomain>
	<200707090852.03429.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707090852.03429.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2007-07-09 at 08:52 +0200, Oliver Neukum wrote:
> Am Sonntag, 8. Juli 2007 schrieb Benjamin Herrenschmidt:
> > Another issue that's been a problem forever with suspend is the
> > synchronous request_firmware interface. Lots of drivers do that in
> > resume() which will generally not work.
> 
> Unfortunately yes they do. We now have the notifier chains, which
> can be used. Firmware, especially if it is large, must be requested
> while the system is still fully functional and paging will work.
> 
> Asynchronocity will not help much because the devices must work
> after resumingand delaying that will not help with respect to needing
> devices to get at the firmware.

True, pre-loading is the best approach.

Ben.
