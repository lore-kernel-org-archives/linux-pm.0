From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH] Corrected Workqueue freezer support.
Date: Thu, 21 Jul 2005 00:56:09 -0500
Message-ID: <200507210056.09515.dtor_core@ameritech.net>
References: <1121923979.2939.237.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============017785074534728107=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1121923979.2939.237.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org, ncunningham@cyclades.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============017785074534728107==
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 21 July 2005 00:32, Nigel Cunningham wrote:
> (Fixed to remove the latent mention of syncthreads).
> 
> This patch implements freezer support for workqueues. The current
> refrigerator implementation makes all workqueues NOFREEZE, regardless of
> whether they need to be or not.
>

I think kseriod and kgameportd threads can be left freezable.

-- 
Dmitry

--===============017785074534728107==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============017785074534728107==--
