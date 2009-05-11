From: Alex Goebel <alex.goebel@gmail.com>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Mon, 11 May 2009 16:23:24 -0700
Message-ID: <faa09fad0905111623t24c3e421t8923c015788e2c56__19131.6672288396$1242084328$gmane$org@mail.gmail.com>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<20090507120948.GA1531@ucw.cz> <200905080037.19722@centrum.cz>
	<20090510053840.GG1363@ucw.cz> <200905112319.8749@centrum.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905112319.8749@centrum.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: trekker.dk@centrum.cz
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 5/11/09, trekker.dk@centrum.cz <trekker.dk@centrum.cz> wrote:

> 1. AMD Athlon 1700+, VIA KT333 chipset based MB, nVidia GeForce 2
> 2. AMD X2 Athlon, AMD690V chipset based MB, nVidia 7600GT
> 3. (current) AMD X4 Phenom II,  AMD780G chipset and nVidia 9600GT
> (binary driver for video card every time)

The nvidia binary driver should generally both s2ram and s2disk with
unpatched kernels for quite some time now. You might have a problem in
userspace (/distribution) with some of the magic options not set
properly for your specific hardware.
Also, if the machine appears dead after resume, you might have to wait
up to ~2 minutes for the GPU to come alive due to a bug in the binary
driver (was only very recently fixed by nvidia).

Alex
