From: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Subject: Re: [PATCH][RFC] swsusp for OSK
Date: Thu, 28 Jul 2005 16:44:18 +0900 (JST)
Message-ID: <20050728.164418.59468314.kaminaga@sm.sony.co.jp>
References: <20050707.111613.107948201.kaminaga@sm.sony.co.jp>
	<20050708.212501.58462280.kaminaga@sm.sony.co.jp>
	<20050708150337.GB16299@home.fluff.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============44165988258919686=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050708150337.GB16299@home.fluff.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: ben-linux@fluff.org
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============44165988258919686==
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH][RFC] swsusp for OSK
Date: Fri, 8 Jul 2005 16:03:37 +0100

> Hmm, I have no idea if this is correct... I assume it is not saving
> the page tables over suspend/resume, and that is why you are having
> trouble restoring the page table? 

I looked more into swapper_pg_dir, and found that on i386, it was 4K
but on ARM, it was 16K.

The remaining 12K of swapper_pg_dir might not be saved across
suspend/resume, and this could be the cause of panic on resume on bigger
image.


HK.
--

--===============44165988258919686==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============44165988258919686==--
