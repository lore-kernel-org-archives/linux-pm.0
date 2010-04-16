From: Frans Pop <elendil@planet.nl>
Subject: Re: [regression] Sound not transferred to docking
	station after resume from StR
Date: Fri, 16 Apr 2010 21:48:36 +0200
Message-ID: <201004162148.37751.elendil__21097.4822556183$1271447377$gmane$org@planet.nl>
References: <201004162131.19171.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201004162131.19171.elendil@planet.nl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, linux-pm@lists.linux-foundation.org, alsa-devel@alsa-project.org
List-Id: linux-pm@vger.kernel.org

On Friday 16 April 2010, Frans Pop wrote:
> With 2.6.33 and earlier the sound would always come from the external
> speakers connected to the docking station. But with 2.6.34-rc4 I get
> sound still coming from the laptop's internal speakers, which is not
> correct.

Forgot to mention that sound does get transferred to the external speakers 
with .34 if I do an extra undock and redock after the resume.
