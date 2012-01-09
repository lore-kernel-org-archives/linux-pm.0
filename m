From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM:Hibernation: drop the check of swap space
 size for compressed image
Date: Mon, 9 Jan 2012 11:10:37 +0100
Message-ID: <20120109101037.GB19903@elf.ucw.cz>
References: <1326084983-22237-1-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1326084983-22237-1-git-send-email-Barry.Song@csr.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Barry Song <Barry.Song@csr.com>
Cc: linux-pm@lists.linux-foundation.org, workgroup.linux@csr.com, linux-arm-kernel@lists.infradead.org, Barry Song <Baohua.Song@csr.com>
List-Id: linux-pm@vger.kernel.org

On Mon 2012-01-09 12:56:23, Barry Song wrote:
> From: Barry Song <Baohua.Song@csr.com>
> 
> For compressed image, the space required is not known until
> we finish compressing and writing all pages.
> This patch drops the check, and if swap space is not enough
> finally, system can still restore to normal after writing
> swap fails for compressed images.
> 
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
