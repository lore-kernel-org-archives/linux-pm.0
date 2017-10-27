From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PULL REQUEST] for Rafael's Linux-PM / For-Next
Date: Fri, 27 Oct 2017 10:00:56 +0200
Message-ID: <CAJZ5v0gAb+H70QjO-urbeL6LyKSPX+NX2ePRHrigu2P0v1EjXg@mail.gmail.com>
References: <CGME20171027003236epcms1p294d11fd0d6e074ec177abe903a2a91b8@epcms1p2>
 <20171027003236epcms1p294d11fd0d6e074ec177abe903a2a91b8@epcms1p2>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:55436 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbdJ0IA5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Oct 2017 04:00:57 -0400
Received: by mail-oi0-f68.google.com with SMTP id g125so9651555oib.12
        for <linux-pm@vger.kernel.org>; Fri, 27 Oct 2017 01:00:57 -0700 (PDT)
In-Reply-To: <20171027003236epcms1p294d11fd0d6e074ec177abe903a2a91b8@epcms1p2>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Myungjoo Ham <myungjoo.ham@samsung.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, "myungjoo.ham@gmail.com" <myungjoo.ham@gmail.com>

On Fri, Oct 27, 2017 at 2:32 AM, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
> Dear Rafael,
>
> Here goes a pull request from PM/devfreq mainly focussing on supporting OPP better.

Thanks!

I will pull when I'm back home, likely on Sunday.


> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> The following changes since commit bb176f67090ca54869fc1262c913aa69d2ede070:
>
>   Linux 4.14-rc6 (2017-10-23 06:49:47 -0400)
>
> are available in the git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git tags/pullreq_20171026
>
> for you to fetch changes up to aa7c352f9841ab3fee5bf1de127a45e6310124a6:
>
>   PM / devfreq: Define the constant governor name (2017-10-26 17:08:40 +0900)
>
> - ----------------------------------------------------------------
> Pull Request from PM/devfreq to Linux-PM
>
> - ----------------------------------------------------------------
> Chanwoo Choi (7):
>       PM / devfreq: Set min/max_freq when adding the devfreq device
>       Revert "PM / devfreq: Add show_one macro to delete the duplicate code"
>       PM / devfreq: Use the available min/max frequency
>       PM / devfreq: Change return type of devfreq_set_freq_table()
>       PM / devfreq: Show the all available frequencies
>       PM / devfreq: Remove unneeded conditional statement
>       PM / devfreq: Define the constant governor name
>
>  drivers/devfreq/devfreq.c                 | 139 +++++++++++++++++++++---------
>  drivers/devfreq/exynos-bus.c              |   5 +-
>  drivers/devfreq/governor_passive.c        |   2 +-
>  drivers/devfreq/governor_performance.c    |   2 +-
>  drivers/devfreq/governor_powersave.c      |   2 +-
>  drivers/devfreq/governor_simpleondemand.c |   2 +-
>  drivers/devfreq/governor_userspace.c      |   2 +-
>  drivers/devfreq/rk3399_dmc.c              |   2 +-
>  include/linux/devfreq.h                   |  16 +++-
>  9 files changed, 123 insertions(+), 49 deletions(-)
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1
>
> iQIcBAEBAgAGBQJZ8n08AAoJEBOhurvWBoCKCWUP+wcU5R/IxENbUf/pM5wykU3x
> PCr67nJSa4Iohg22BzmJo0MkXC7AoNwajc/rPgYlrnHwd1arPcDKjF/Mi8+0cJNS
> hRuqKW3w67+rbiBnYvhHeLT2U1Ik0CQPEICeNM/pn0yDUVMPIEQUpBS2W3ghx8OG
> 3sufqxqsyMESnYmHluJAE9G3cFhxPipMNkd+cSA/xzqQxGO0ALsXAdSc/XJv9zVE
> beiNIKz137XyddHA2Rwbcs9EL6swf6oDj6qPvXjsPPncG+pxoXydMmvjY5veMgW2
> Hc49iTXLk2/srKIfhkpTyVHN4Y0MeDHJRwNaUm4i6OpWlZWR5J5tBw0mQYFLa81p
> X9K5mtu6YllVu2MV+hEe6sqgDVVEnii1tQJ5uNDrT028/24Pe84LQGZvqNwBn2wP
> APqvDQjCZObw0CS/RqVSKUvAmOS3+HmYJJEwaBmhK1j+ga4iFg1/MIDsFfuVEZIC
> fhTw4TMbhsBHKqT1uRoHfS55q+hGXIMqtd1ZgvY/Cu/gX7h8ZKeW5ehVaJ/WA6iP
> wLAf3WQHWgClDbe9mIU4nMQVrcp4DV3abQvbIzHzHOLN2HVwOgF2aX6wci95Iz1L
> gWt6iP2ZhMqX19erIUp9W7B2WSGMto/vAA7Lhrm/w3nFl54f3r8wLoREBifjrRs/
> 2gBILsa/5o/eZOjcbayI
> =J1Ix
> -----END PGP SIGNATURE-----
