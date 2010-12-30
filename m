From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: i2c runtime suspend and system wide suspend
Date: Thu, 30 Dec 2010 11:35:03 +0000
Message-ID: <20101230113502.GA8537__7792.58427578515$1293708975$gmane$org@opensource.wolfsonmicro.com>
References: <4D1C0CFE.5010008@codeaurora.org>
	<AANLkTinqqgNwgFCMVL-2T83zKnNLGLF007atJ4-EDEW5@mail.gmail.com>
	<201012301149.30888.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201012301149.30888.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Partha Basak <p-basak2@ti.com>, linux-arm-msm@vger.kernel.org, Abhijeet Dharmapurikar <adharmap@codeaurora.org>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 30, 2010 at 11:49:30AM +0100, Rafael J. Wysocki wrote:
> On Thursday, December 30, 2010, Rabin Vincent wrote:

> > https://lists.linux-foundation.org/pipermail/linux-pm/2010-December/029658.html

> I'm not sure what happened to the last patch.  Is there a new version?
> If so, is it going to be pushed through the i2c tree, or should I take it?

Jean appears to be on holiday for the Christmas vacation.  I do have a
new version which I'll post later today.  Since it depends on the patch
protoyping the generic API calls which the SPI patch also depends on
it'd probably be best to merge via your tree.
