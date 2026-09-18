Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664663D9680;
	Fri, 18 Sep 2026 02:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789699256; cv=none; b=kBvSN2+MYKt0qjsCjR+HEZbIwMilgt+xGE869+lbETFZYLQvtUkN+IjpGAJZodlSvoum2x+c1EuD6yYm9ZEWfsaKI7DdXPxKK4YG8Qk9XDBJDColCV8fs2iom1Gwa6pjSuybb2ak+tvolEkSzM3vaMtF94gtdq+tghyFi9TaftE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789699256; c=relaxed/simple;
	bh=vX1oH9OH1GKzwXjdYNaZSPlTagRimiE4pEJyduCBULA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=omTIARyc91bwF3eWwyhaCWCgFhTiC7vsIBmYf6usVR8QP0sf9cS/Qi9ggJTz8/oS/tMEPvhxnZdYIsxCkOpwczcVxvTrjURsQclUCondUQ26K1Gji/YjcYkxQTOYd95EcimIRA998TttiABZdEwoEzixbDSt0yYLBaUN6J/jD8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQdS4Tk1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQdS4Tk1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E32D1F00899;
	Fri, 18 Sep 2026 02:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789699242;
	bh=5IeGjUN7fXw7p9Xz+5Tbudirtuv11NiQpLTAxyNiadk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KQdS4Tk1uWgHQaFv98UNLA8tQ4F7LMlO26PIbaun98U7pnsFLktqyO4rBxIJGDyi7
	 VLJ+4vELWdYbwvUuRn95XFscFcCddNGz7Q9TH6y8TvhBIDAO4v04w+fdEAABZh+5Xg
	 ol5uIEislJNS39VC3A5qrg0dU7zayRb1copPl0FvZrn4yYy9DSIO8/826UikCpcfSH
	 wwuaoa8X9x0SUGyRTu20Rhz4YuLo2BMVV0zHMxXZYZXLjQGeLwZSxXQseUys67CtkE
	 S0JUrGA7gjyyOYVf9Xmm6t4GuJ/QmLwrGjwrjgZ/YV/tpKPmqHWP7+MQ4yW7pica5c
	 6VG2IiVNUzFAQ==
From: Yixun Lan <dlan@kernel.org>
Date: Fri, 18 Sep 2026 02:40:15 +0000
Subject: [PATCH 3/3] dts: riscv: spacemit: Add power domain nodes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-04-k3-pm-support-v1-3-0acd2b36b96f@kernel.org>
References: <20260918-04-k3-pm-support-v1-0-0acd2b36b96f@kernel.org>
In-Reply-To: <20260918-04-k3-pm-support-v1-0-0acd2b36b96f@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187; i=dlan@kernel.org;
 h=from:subject:message-id; bh=vX1oH9OH1GKzwXjdYNaZSPlTagRimiE4pEJyduCBULA=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqrKSYUhRJxzcpB1oSOW2nwIHpBOLxwgymvV4sZ
 Zmsmiq81tqJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCaqykmBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+1xiA/9Fezfv05YmStKUfOLohH7paXlxs9vU1Fs21qaZNxdYpg8xj7+ZH9g1
 HSn0f6zqSa8EkEOZtHAc19ifc0lLKOhMut2cinhP8QkQMr1qH2NS42Y/RifE+x9TJEsEPbvvUi9
 3+0ty1MibOUBI9oTdPSi2XROGHD7ydw2VCPZfBsy/BRHp1p71XEDJn9irkGVUbLUyjy+1DpJp/c
 j8472nDjbNDraMwh3HGUEAjSY3gLnV4KbsQyjGoeEdbVv8zLoky0OUljxqMFwllM14Yefac9q48
 8+Ar6xPGnZjYqFj8TzkzeOjrga06kkeB4JukvLInvhaB6OmOJdEu1MOr6pys9uoSQVuJz2HS2rt
 4+hyu9VvifpnwZbQh3vb9IgDmDkGolyZM6P4Y4jCObu/jy4/bWeJeQD0htZxOKK45W+D2D4Hp6J
 1ZaMYo6oQIZynXMlvXqba4nbhLS4yI3njX7ir0NbGnrYTUtkM4hTmzwSzmgqOa/fC+FaS/N6QTn
 rJzCeJUmZiXRD32e7YvdKoTJpnYMIPFV/ttKewnZI8KYU+i0tE3EBuiXdnnmTAMNtBYsywEojIE
 JuxQ3DhZ7dUKxwH5es1ubSTtnj+Pakis3BCgBPb29EQ7+ruhy8SC/MobRyw3UdWP6RhyPiafKzG
 tYR+Af4YQcKAkO/54KJ3BOmMWGeFHQ=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

Populate the power domain device tree nodes for K1/K3 SoC.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 arch/riscv/boot/dts/spacemit/k1.dtsi | 6 ++++++
 arch/riscv/boot/dts/spacemit/k3.dtsi | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index 3fabfd34114b..871c913e6fb4 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -1352,4 +1352,10 @@ emmc: mmc@d4281000 {
 			};
 		};
 	};
+
+	pwrc: power-controller {
+		compatible = "spacemit,k1-power-controller";
+		spacemit,apmu = <&syscon_apmu>;
+		#power-domain-cells = <1>;
+	};
 };
diff --git a/arch/riscv/boot/dts/spacemit/k3.dtsi b/arch/riscv/boot/dts/spacemit/k3.dtsi
index c3f2dce0969c..1bf25a657762 100644
--- a/arch/riscv/boot/dts/spacemit/k3.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
@@ -1306,4 +1306,10 @@ maplic: interrupt-controller@f1800000 {
 			status = "reserved";
 		};
 	};
+
+	pwrc: power-controller {
+		compatible = "spacemit,k3-power-controller";
+		spacemit,apmu = <&syscon_apmu>;
+		#power-domain-cells = <1>;
+	};
 };

-- 
2.55.0

