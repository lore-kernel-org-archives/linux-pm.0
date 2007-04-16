From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [3/3] 2.6.21-rc6: known regressions
Date: Mon, 16 Apr 2007 14:45:24 +0800
Message-ID: <1176705924.5129.1.camel@daplas>
References: <Pine.LNX.4.64.0704051944230.6730@woody.linux-foundation.org>
	<200704151826.33837.marcus@better.se> <1176678525.16909.3.camel@daplas>
	<200704160823.39074.marcus@better.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704160823.39074.marcus@better.se>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Marcus Better <marcus@better.se>
Cc: linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2007-04-16 at 08:23 +0200, Marcus Better wrote:
> > Just for clarification, do you suspend from VESA framebuffer console or
> > from VGA text console?
> =

> From VESA console.

Have you tried other combinations?

s2ram -m -p -f
s2ram -s -p -f

Tony
