From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Warning with asm-generic/div64.h
Date: Tue, 29 Mar 2011 13:58:56 +0200
Message-ID: <201103291358.56758.arnd__19223.4310824007$1301400043$gmane$org@arndb.de>
References: <007801cbead6$1984b6e0$4c8e24a0$@mprc.pku.edu.cn>
	<201103251439.53568.arnd@arndb.de>
	<018a01cbee06$534730a0$f9d591e0$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <018a01cbee06$534730a0$f9d591e0$@mprc.pku.edu.cn>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: linux-arch@vger.kernel.org, 'Len Brown' <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 29 March 2011, Guan Xuetao wrote:
> > The macro doesn't work for signed input or for 32 bit input. I'd suggest
> > fixing the caller to use an unsigned type.
> 
> Then,
> Cc: Len Brown <len.brown@intel.com> (supporter:SUSPEND TO RAM)
> Cc: Pavel Machek <pavel@ucw.cz> (supporter:SUSPEND TO RAM)
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl> (supporter:SUSPEND TO RAM)
> Cc: linux-pm@lists.linux-foundation.org (open list:SUSPEND TO RAM)

Yes, that sounds right.

	Arnd
