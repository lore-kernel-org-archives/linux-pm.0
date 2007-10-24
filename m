From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [2.6 patch] kernel/power/disk.c: make code static
Date: Wed, 24 Oct 2007 20:22:05 +0200
Message-ID: <20071024182205.GB5093__49663.1342721686$1193250199$gmane$org@elf.ucw.cz>
References: <20071024162342.GU30533@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071024162342.GU30533@stusta.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed 2007-10-24 18:23:42, Adrian Bunk wrote:
> resume_file[] and create_image() can become static.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

ACK.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
