From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH] ARM hibernation / suspend-to-disk
	support code
Date: Fri, 20 May 2011 19:07:48 +0100
Message-ID: <20110520180748.GF7445__7644.78058922595$1305914987$gmane$org@n2100.arm.linux.org.uk>
References: <3DCE2F529B282E4B8F53D4D8AA406A07014FFE@008-AM1MPN1-022.mgdnok.nokia.com>
	<alpine.DEB.2.00.1105181257370.2374@localhost6.localdomain6>
	<20110520113758.GA3141@arm.com>
	<alpine.DEB.2.00.1105201255260.8018@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1105201255260.8018@localhost6.localdomain6>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frank Hofmann <frank.hofmann@tomtom.com>
Cc: Dave Martin <dave.martin@linaro.org>, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, tuxonice-devel@tuxonice.net
List-Id: linux-pm@vger.kernel.org

On Fri, May 20, 2011 at 01:39:37PM +0100, Frank Hofmann wrote:
> I've simply done there what the "setmode" macro from <asm/assembler.h>  
> is doing, have chosen not to include that file because it overrides 
> "push" on a global scale for no good reason and that sort of thing makes 
> me cringe.

"push" was never an ARM instruction until someone decided to make r13
"special".  As our macros there pre-date the invention of the new ARM
instruction neumonics, it takes precident _especially_ as there's
perfectly good alternative ways to say "push" to the assembler.
