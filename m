From: Liam Girdwood <lrg@kernel.org>
Subject: Re: New comer in the linux-pm list
Date: Thu, 20 Nov 2008 15:54:59 +0000
Message-ID: <1227196499.585.39.camel@vega.slimlogic.co.uk>
References: <OF87B4B960.116849D3-ONC1257507.00457478-C1257507.0045AAE5@sagem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <OF87B4B960.116849D3-ONC1257507.00457478-C1257507.0045AAE5@sagem.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David GIGUET <david.giguet@sagem.com>
Cc: Olivier LE ROY <olivier.leroy@sagem.com>, Kanider GUENDOUZI <kanider.guendouzi@sagem.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2008-11-20 at 13:40 +0100, David GIGUET wrote:
> 
> I am forwarding an e-mail from N. PAJANI, one of our collaborator.
> 
> 
> Hi all
> 
> I have made some googling and read some code from the kernel, but I
> did not managed to find a "power management scheme" outside of APM or
> ACPI to fit my needs.
> My goal is to have something relevent for embeded devices (or at least
> battery powered), not only servers, desktop or laptops, though it may
> apply to these.
> 
> For example on a cellphone, when you switch to "silent mode" what need
> do you have to power the audio amplifier, and maybe the audio module
> inside the SOC may be stopped, saving more power.

ALSA Soc (ASoC) does this sort of thing already. It can power down
unused audio components when not in use. Have a look at DAPM in
sound/soc and Documentation/sound/alsa/soc for details.

> Or fully powering Wifi or Ethernet when they are not in use on a
> "netbook" is also an unuseful loss of power.
> 

The voltage regulator framework will allow powerdown of Ethernet/Wifi
when not in use (provided they are supplied power by a by a software
controlled regulator). 

Liam
