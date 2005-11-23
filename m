From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [Patch 0/6] Remove Deprecated PM Interface from
	Obsolete Sound Drivers
Date: Wed, 23 Nov 2005 21:57:10 +0100
Message-ID: <20051123205710.GW3963@stusta.de>
References: <Pine.LNX.4.50.0511231114340.14446-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============72225566237253713=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0511231114340.14446-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: akpm@osdl.org, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============72225566237253713==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 23, 2005 at 12:23:25PM -0800, Patrick Mochel wrote:
> 
> Hi there.

Hi Patrick,

> This is a series of 6 patches that remove the old, deprecated power
> management interface from a variety of old OSS drivers, most of them
> marked OBSOLETE and scheduled for removal in January 2006.
> 
> These patches facilitate the removal of the ancient PM interface by
> reducing the number of in-kernel users to 3:
> 
> 	drivers/net/3c509.c
> 	drivers/net/irda/ali-ircc.c
> 	drivers/serial/68328serial.c
>...
> Does any one have any objections to these patches?

I'd say the obsolete OSS drivers are the least problem, it would be more  
interesting to get the code fixed that will still be present two months  
from now.

Looking at the current state of 2.6.15, I doubt your patches would make 
it into Linus' tree earlier than the complete removal of the drivers.

> Thanks,
> 
> 	Pat
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


--===============72225566237253713==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============72225566237253713==--
