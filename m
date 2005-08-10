From: "Brown, Len" <len.brown@intel.com>
Subject: RE: Re: PM Summit in Ottawa
Date: Wed, 10 Aug 2005 15:15:14 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30044D1E3B@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: david-b@pacbell.net, linux-pm@lists.osdl.org
Cc: abelay@novell.com, ncunningham@cyclades.com, vojtech@suse.cz, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org


>Len Brown assured the group that Intel is putting pressure on BIOS
>writers and system vendors with Intel chipsets to support Linux
>especially with regard to power management. If this works out as well
>as planned, it means that the BIOS will reinitialize the video chipset
>when resuming, so Linux won't have to worry about it. However, this
>will only be true for platforms with Intel video hardware.

Actually, Centrino platforms may include a variety of video controllers,
and this guidance is given and applies to all, including Intel,
ATI, Nvidia or whatever the system designer chooses.

The bad news is that BIOS developers are not necessarily
good listeners...

cheers,
-Len
