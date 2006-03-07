From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: apm for individual devices
Date: Mon, 6 Mar 2006 22:50:43 -0500
Message-ID: <20060307035043.GA4312@neo.rr.com>
References: <440CD773.6010401@greyinnovation.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9742891285314208=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <440CD773.6010401@greyinnovation.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Tehn Yit Chin <tehn-yit.chin@greyinnovation.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============9742891285314208==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 07, 2006 at 11:44:35AM +1100, Tehn Yit Chin wrote:
> Hi all,
> 
> How does one use the sysfs entry of power/state that I can find for each 
> registered device? Eg, for the i2c device on my s3c2410 cpu, I find the 
> following entry,
> 
> /sys/devices/platform/s3c2410-i2c/power/state
> 
> I tried echoing "mem" into it, but nothing seems to happen.
> 
> What I am looking for is a way of suspending and resuming individual 
> devices within the PM architecture?
> 
> Any pointers would be greatly appreciated.
> --

Out of curiousity, why do you need to suspend this individual device?
In other words, what practical runtime power management gains would this
sort of low level and specific power management control provide for your
purposes?

Thanks,
Adam


--===============9742891285314208==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============9742891285314208==--
