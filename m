From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: potential pitfall? changing configuration while PC in
	hibernate
Date: Mon, 21 Mar 2005 10:52:29 +0100
Message-ID: <20050321095229.GA28507@elf.ucw.cz>
References: <d1lutv$iuj$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============91672717060912234=="
In-Reply-To: <d1lutv$iuj$1@sea.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Arioch <the_Arioch-SYPjacQAEmk@public.gmane.org>
Cc: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============91672717060912234==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Po 21-03-05 11:02:04, Arioch wrote:
> AS: where it counts, by hibernate i mean Suspend-to-disk, not 
> suspend-to-RAM.
> 
> I wonder, if hardware configuration asked for changes when resuming from 
> hibernate ?

Current position is "don't do this". You *will* be able to recover by
passing noresume, but if you change hw configuration, it may crash&burn.
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============91672717060912234==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============91672717060912234==--
